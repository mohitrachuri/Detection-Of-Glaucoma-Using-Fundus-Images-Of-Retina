const databaseManager = require("./../databaseManager/database_manager");

function Flags() {

    this.db = databaseManager.databaseManager;

    this.flagCourse = function(courseId, flagsCallback) {
        flagsInstance = this;
        this.db.getFlags(function(rows) { 
            var courseIdAlreadyFlagged = false;
            for (var i = 0; i < rows.length; i++) {
                if (rows[i].course_id == courseId) {
                    courseIdAlreadyFlagged = true;
                }
            }

            if (!courseIdAlreadyFlagged) {
                flagsInstance.db.addFlag(courseId, flagsCallback);
            }
        });
    }

    this._getCourseInformationFromIds = function(courseIds, courseObjects, finalFlagsCallback) {
        if (courseIds.length == 0) {
            console.log(courseObjects);
            finalFlagsCallback(courseObjects);
        } else {
            firstCourseId = courseIds[0];
            flagsInstance = this;
            this.db.getCourseFromId(firstCourseId, function(rows) {
                courseObj = rows[0];
                courseIds.shift();
                courseObjects.push(courseObj);
                flagsInstance._getCourseInformationFromIds(courseIds, courseObjects, finalFlagsCallback);
            });
        }
    }

    this.getFlaggedCourses = function(flagsCallback) {
        flagInstance = this;
        this.db.getFlags(function(rows) {
            courseIds = [];
            for (var i = 0; i < rows.length; i++) {
                courseIds.push(rows[i].course_id);
            }
            flagInstance._getCourseInformationFromIds(courseIds, [], flagsCallback);
        });
    }

    this.deleteCourse = function(courseId, flagsCallback) {
        flagInstance = this;
        this.db.deleteCourse(courseId, flagsCallback);
    }
}

exports.Flags = Flags;