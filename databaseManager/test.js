const databaseManager = require("./database_manager");

var db = databaseManager.databaseManager;

// db.getCourses(printResponse);

// db.getUserCredentials(2, printResponse);

function Student() {
    this.first_name = "test_first_name",
    this.last_name = "test_last_name",
    this.email = "yeahboy@gmail.com",
    this.password = "bunnies",
    this.wishlist_id = 2,
    this.course_id_list = "";
}
// db.addNewStudent(new Student());

// db.addDiscussion(3, "i have an iq of 48 but i think im pretty smart");

db.getUserCredentials("asdfasdf", function(results) {
    console.log(results);
})