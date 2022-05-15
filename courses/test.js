const courses = require("./courses");

coursesObj = new courses.Courses();

coursesObj.addNewCourse({title: "New Course", category: 1, description: "Description", instructor_id: "1"},
function() {
    console.log("Finished!");
});