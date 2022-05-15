
const databaseManager = require("./../databaseManager/database_manager");

function Wishlist() {

    this.db = databaseManager.databaseManager;

    this.addToWishlist = function(course, currentUser, wishlistCallback) {
        wishlistInstance = this;
        this.db.getWishlist(currentUser, function(results) {
            var ids;
            console.log(results);
            if ((results == null) || (results.length == 0)) {
                ids = [];
                ids.push(course);
                console.log(ids);
                newIdsAsJson = JSON.stringify(ids);
                wishlistInstance.db.setFirstWishlist(newIdsAsJson, currentUser, wishlistCallback);
            } else {
                ids = JSON.parse(results[0].course_id_list);
                ids.push(course);
                console.log(ids);
                newIdsAsJson = JSON.stringify(ids);
                wishlistInstance.db.setWishlist(newIdsAsJson, currentUser, wishlistCallback);
            }
        });
    }

    this._getCourseInformationFromIds = function(courseIds, courseObjects, finalWishlistCallback) {
        console.log("Course IDs:");
        console.log(courseIds);
        if (courseIds.length == 0) {
            finalWishlistCallback(courseObjects);
        } else {
            firstCourseId = courseIds[0];
            wishlistInstance = this;
            this.db.getCourseFromId(firstCourseId, function(rows) {
                courseObj = rows[0];
                courseIds.shift();
                courseObjects.push(courseObj);
                wishlistInstance._getCourseInformationFromIds(courseIds, courseObjects, finalWishlistCallback);
            });
        }
    }

    this.getWishlistCourses = function(currentUser, wishlistCallback) {
        wishlistInstance = this;
        this.db.getWishlist(currentUser, function(rows) {
            relevant_row = rows[0];
            courseIdList = JSON.parse(relevant_row.course_id_list);
            wishlistInstance._getCourseInformationFromIds(courseIdList, [], wishlistCallback);
        });
    }
}

exports.Wishlist = Wishlist;
