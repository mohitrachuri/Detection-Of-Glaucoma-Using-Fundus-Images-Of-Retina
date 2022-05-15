const flags = require("./flags");

flagObj = new flags.Flags();

flagObj.getFlaggedCourses(function(courseObjects) {
    console.log(courseObjects);
});
