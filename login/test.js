const login = require("./login");

login.login.verifyCredentials("asdfasdf", "hallo", function(booleanSuccess) {
    console.log("The authentication was a...");
    if (booleanSuccess) {
        console.log("Success!");
    } else {
        console.log("Failure!");
    }
});