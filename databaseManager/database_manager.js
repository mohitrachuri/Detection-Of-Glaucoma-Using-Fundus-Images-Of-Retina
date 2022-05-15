const mysql = require('mysql2');
const util = require('util');


function DatabaseManager() {

    this.latestCourses = [];
    this.lastCoursesUpdate = -1;

    // connecting to mysql database 
    const db = mysql.createConnection({
        host: '54.174.115.150',
        user: 'knowledgegrab',
        password: 'knowledgegrab',
        database: 'kgDB',
        port: 3306
    });

    // check database connection 
    db.connect(err => {
        if (err) { console.log(err, 'dbError!'); }
        console.log('Database Connected...');
    });


    this.getCourses = function(callback) {
        coursesResult = db.query('SELECT * FROM course', function(err, result, fields) {
            callback(result);
        });
    }

    this.getCourseFromId = function(courseId, callback) {
        db.query('SELECT * FROM course WHERE course_id = ' + courseId, function(err, result, fields) {
            if (err) { console.log(err); }
            callback(result);
        });
    }

    this.getCourseModules = function(courseId, callback) {
        db.query('SELECT * FROM course_module WHERE parent_course_id = ' + courseId, function(err, result, fields) {
            callback(result);
        });
    }

    this.getWishlist = function(userId, callback) {
        coursesResult = db.query('SELECT * FROM wishlist WHERE student_id = ' + userId,
            function(err, result, fields) {
                console.log(result);
                callback(result);
            });
    }

    this.getUserCredentials = function(userEmail, callback) {
        db.query("SELECT * FROM student WHERE email = '" + userEmail + "'",
            function(err, result, fields) {
                callback(result);
            });
    }

    this.getExamQuestions = function(quizId, callback) {
        db.query('SELECT * FROM question WHERE quiz_id = ' + quizId,
            function(err, result, fields) {
                callback(result);
            });
    }

    this.getExamForCourse = function(courseId, callback) {
        db.query('SELECT * FROM quiz WHERE course_course_id = ' + courseId,
            function(err, result, fields) {
                callback(result);
            });
    }

    this.getFlags = function(callback) {
        db.query('SELECT * FROM flag',
            function(err, result, fields) {
                callback(result);
            });
    }

    this.addNewStudent = function(student, callback) {
        db.query("INSERT INTO `student` \
        (`first_name`, `last_name`, `email`, `password`) \
        VALUES \
        ('" + student.first_name + "', '" + student.last_name + "', '" + student.email + 
        "', '" + student.password + "');", 
        function(err, result, fields) {
            if (err) { console.log(err); }
            callback();
        });
    }

    this.setFirstWishlist = function(coursesAsJson, userId, callback) {
        db.query("INSERT INTO `wishlist` (`student_id`, `course_id_list`) VALUES (" + userId + ", '" + coursesAsJson + "');",
            function(err, result, fields) {
                if (err) { console.log(err); }
                callback();
            });
    }

    this.setWishlist = function(coursesAsJson, userId, callback) {
        console.log("UPDATE `wishlist` SET \
        `course_id_list` = '" + coursesAsJson + "' WHERE (`student_id` = '" + userId + "');");
        db.query("UPDATE `wishlist` SET \
        `course_id_list` = '" + coursesAsJson + "' WHERE (`student_id` = '" + userId + "');",
            function(err, result, fields) {
                if (err) { console.log(err); }
                callback();
            });
    }

    this.addQuiz = function(courseId, callback) {
        db.query("INSERT INTO `quiz` \
        (`course_course_id`) \
        VALUES \
        (" + courseId + ");", function(err, results, fields) {
            if (err) { console.log(err); }
            callback();
        });
    }

    this.addQuestion = function(questionText, optionA, optionB, optionC, optionD, answer, callback) {
        db.query("SELECT max(quiz_id) from `quiz`;", function(err, result, fields) {
            max = result[0]["max(quiz_id)"];

            db.query("INSERT INTO `question` \
            (`quiz_id`, `optionA`, `optionB`, `optionC`, `optionD`, `answer`, `questionText`) \
            VALUES \
            ('" + max + "', '" + optionA + "', '" + optionB + "', '" + optionC + "', '" + optionD + "', '" + answer + "', '" + questionText + "');", function(err, results, fields) {
                callback();
            });
        });
    }

    this.addFlag = function(courseId, callback) {
        db.query("INSERT INTO `flag` \
        (`course_id`) \
        VALUES \
        ('" + courseId + "');", function(err, results, fields) {
            callback();
        });
    }

    this.addCourse = function(title, category_id, isFlagged, student_id_list, meta_data, instructor_id, callback) {
        db.query("INSERT INTO `course` \
        (`title`, `category_category_id`, `isFlagged`, `student_id_list`, `meta_data`, `instructor_instructor_id`) \
        VALUES \
        ('" + title + "', '" + category_id + "', '" + isFlagged + "', '" + student_id_list + "', '" + meta_data + "', '" + instructor_id + "');", function(err, results, fields) {
            if (err) { console.log(err); }
            callback();
        });
    }

    this.deleteCourse = function(courseId, callback) {
        db.query("DELETE FROM `course` WHERE (`course_id` = '" + courseId + "');", function(err, results, fields) {
            if (err) { console.log(err); }
            callback();
        });
    }

    this.addCourseModule = function(courseId, title, video_link, description, callback) {
        db.query("INSERT INTO `course_module` \
        (`title`, `parent_course_id`, `video_link`, `Text_description`) \
        VALUES \
        ('" + title + "', '" + courseId + "', '" + video_link + "', '" + description + "');", 
         function(err, results, fields) {
            if (err) { console.log(err); }
            callback();
        });
    }

    this.addDiscussion = function(courseId, discussionText) {
        db.query("INSERT INTO `discussion` \
        (`course_id`, `discussion_text`) \
        VALUES \
        ('" + courseId + "', '" + discussionText + "');");
    }

    this.getDiscussion = function(courseId, callback) {
        db.query('SELECT * FROM discussion',
            function(err, result, fields) {
                if (err) { console.log(err); }
                callback(result);
            });
    }

    // TODO - how is instructor related to a student? 

}

exports.databaseManager = new DatabaseManager();
