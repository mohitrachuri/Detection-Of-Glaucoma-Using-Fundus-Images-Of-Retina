
const databaseManager = require("./../databaseManager/database_manager");

function Exams() {

    this.db = databaseManager.databaseManager;

    this._insertExamQuestions = function(questions, examCallback) {
        examInstance = this;
        if (questions.length == 0) {
            examCallback();
        } else {
            thisQuestion = questions[0];
            questions.shift();
            examInstance.db.addQuestion(thisQuestion.questionText, 
                                        thisQuestion.optionA,
                                        thisQuestion.optionB,
                                        thisQuestion.optionC,
                                        thisQuestion.optionD,
                                        thisQuestion.answer,
                                        function() {
                                            examInstance._insertExamQuestions(questions, examCallback);
                                        });
        }
    }

    this.setExamForCourse = function(courseId, exam, examCallback) {
        examInstance = this;
        this.db.addQuiz(courseId, function() {
            examInstance._insertExamQuestions(exam.questions, examCallback);
        });
    }

    this.getGradeFromExam = function(courseId, inputAnswers, examCallback) {
        examInstance = this;
        this.db.getExamForCourse(courseId, function(rows) {
            examId = rows[0].quiz_id;
            examInstance.db.getExamQuestions(examId, function(examQuestions) {
                totalNumberQuestions = examQuestions.length;
                numberCorrect = 0;
                for (var i = 0; i < totalNumberQuestions; i++) {
                    if (inputAnswers[i] === examQuestions[i].answer) {
                        numberCorrect += 1;
                    }
                }
                examCallback(numberCorrect / totalNumberQuestions);
            })
        })
    }

    this.getExamForCourse = function(courseId, examCallback) {
        examInstance = this;
        this.db.getExamForCourse(courseId, function(results) {
            examInstance.db.getExamQuestions(results[0].quiz_id, examCallback);
        });
    }
}

exports.Exams = Exams;