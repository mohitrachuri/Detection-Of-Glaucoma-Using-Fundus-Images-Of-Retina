const exams = require("./exams");

examObj = new exams.Exams();

// examObj.setExamForCourse(3, {questions: [
//     {questionText: "Who are you?",
//     optionA: "A cool guy",
//     optionB: "A hip guy",
//     optionC: "A really cool dude",
//     optionD: "A loser :(",
//     answer: "A loser :("}
// ]}, function() {
//     console.log("Finished with inserting the exam question!");
// });

// examObj.getGradeFromExam(1, ["fuck off", "A loser :)"], function(gradeAsDecimal) {
//     console.log("The grade the user got for this exam was:");
//     console.log(gradeAsDecimal);
// });

examObj.getExamForCourse(1, function(questions) {
    console.log("Questions for the exam:");
    for (var i = 0; i < questions.length; i++) {
        console.log(questions[i]);
    }
});