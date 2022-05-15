/* Defines a node in a Trie. 
   Each node has a reference to a Course object. */

function TrieNode() {
    this.courses = [];
    this.childrenNodes = {}; // Dictionary between letter and sub-tree

    this.putInTrie = function(keyString, courseObject) {
        // If this is the end of the string, simply add the course
        if (keyString == "") {
            this.courses.push(courseObject);
            
        } else {
            // Otherwise, go to the appropriate child node and continue
            var firstCharacter = keyString.charAt(0);
            if (!(firstCharacter in this.childrenNodes)) {
                this.childrenNodes[firstCharacter] = new TrieNode();
            }

            var childNode = this.childrenNodes[keyString.charAt(0)];
            var restOfString = keyString.substring(1);
            childNode.putInTrie(restOfString, courseObject);
        }
    }

    this.getCoursesFromString = function(keyString) {
        if (keyString === "") {
            outputCourses = [...this.courses];
            console.log("How many children does this unit have?" + this.childrenNodes.length);
            console.log(this.childrenNodes);
            for (var childNodeKey in this.childrenNodes) {
                console.log("Child node key:");
                console.log(childNodeKey);
                thisChildNode = this.childrenNodes[childNodeKey];
                childCourses = thisChildNode.getCoursesFromString("");

                Array.prototype.push.apply(outputCourses, childCourses);
            }

            return outputCourses;

        } else {
            firstCharacter = keyString.charAt(0);
            restOfString = keyString.substring(1);

            relevantChild = this.childrenNodes[firstCharacter];
            if (relevantChild) {
                results = relevantChild.getCoursesFromString(restOfString); 
                return results;
            } else {
                return [];
            }
        }
    }
}

exports.TrieNode = TrieNode;
