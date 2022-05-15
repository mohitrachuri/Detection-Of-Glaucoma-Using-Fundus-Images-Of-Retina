
const databaseManager = require("./../databaseManager/database_manager");

function Login() {

    this.verifyCredentials = function(userEmail, userPassword, loginCallback) {
        this.db.getUserCredentials(userEmail, function(userObjects) {
            user = userObjects[0];
            if (user == undefined) {
                loginCallback(false);
            }
            else if (userPassword == user.password) {
                loginCallback(user.student_id.toString());
            } else {
                loginCallback(false);
            }
        });
    }

    this.addNewUser = function(userObject, loginCallback) {
        this.db.addNewStudent(userObject, function() {
            loginCallback();
        });
    }

    this.db = databaseManager.databaseManager;

}

exports.Login = Login;
