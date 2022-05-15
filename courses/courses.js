const databaseManager = require("./../databaseManager/database_manager");

function Courses() {

    this.db = databaseManager.databaseManager;

    this.addNewCourse = function(courseObj, courseCallback) {
        this.db.addCourse(courseObj.title, courseObj.category, 0, [], courseObj.description, courseObj.instructor_id, courseCallback);
    }

    this.getCourseFromId = function(courseId, courseCallback) {
        this.db.getCourseFromId(courseId, courseCallback);
    }

    this.getFullCourse = function(courseId, courseCallback) {
        courseInstance = this;
        this.db.getCourseFromId(courseId, function(rows) {
            course = rows[0];
            courseInstance.db.getCourseModules(courseId, function(courseModules) {
                course.modules = courseModules;
                courseCallback(course);
            });
        });
    }

    this.getAllCourses = function(courseCallback) {
        this.db.getCourses(courseCallback);
    }
}

exports.Courses = Courses;