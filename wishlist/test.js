const wishlist = require("./wishlist");

wishlistObj = new wishlist.Wishlist();

wishlistObj.getWishlistCourses(1, function(courseObjects) {
    console.log("All finished");
    for (var i = 0; i < courseObjects.length; i++) {
        console.log(courseObjects[i]);
    }
})