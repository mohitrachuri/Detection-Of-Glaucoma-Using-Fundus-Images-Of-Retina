/* Implements the Search functionality */

const trie_node = require("./trie_node");
const databaseManager = require("./../databaseManager/database_manager");

const IGNORED_WORDS = ["FOR", "A", "IS", "WAS", "AN", "OF", "AND", "THE", "ARE"];

function Search() {

    this.trieRoot = new trie_node.TrieNode();

    this.searchClasses = function(inputString) {

        // Make a list of upper-case words in the search query
        inputString = inputString.toUpperCase();
        words = inputString.split(" ");

        // Remove the irrelevant words (like 'or' and 'of')
        relevant_words = [];
        for (var i in words) {
            if (IGNORED_WORDS.indexOf(words[i]) < 0) {
                relevant_words.push(words[i]);
            }
        }

        // Get the search results for each individual word
        outputElements = [];
        for (i in relevant_words) {
            relevant_word = relevant_words[i];
            var outputsForThisWord = this.trieRoot.getCoursesFromString(relevant_word);
            for (j in outputsForThisWord) {
                outputForThisWord = outputsForThisWord[j];
                outputElements.push(outputForThisWord);
            }
        }

        return outputElements;
    }

    this.putInTrie = function(keyString, courseObject) {

        // Make a list of capitalized words in the course title
        keyString = keyString.toUpperCase();
        words = keyString.split(" ");

        // Remove the irrelevant words (like 'or' and 'of')
        relevant_words = [];
        for (i in words) {
            word = words[i];
            if (IGNORED_WORDS.indexOf(word) < 0) {
                relevant_words.push(word);
            }
        }

        // Add the course under each relevant word from the query string
        for (i in relevant_words) {
            relevant_word = relevant_words[i];
            this.trieRoot.putInTrie(relevant_word, courseObject);
        }
    }

    // On construction, fetch a list of all courses from the database 
    // and put them in the trie
    // TODO

    // this.putCoursesInTrie = function(results) {
    //     console.log("All courses:");
    //     console.log(results);
    //     for (var result in results) {
    //         this.putInTrie(result.title, result);
    //     }
    // }

    this.db = databaseManager.databaseManager;

    var searchInstance = this;
    this.db.getCourses(function(results) {
        for (var i = 0; i < results.length; i++) {
            result = results[i];
            searchInstance.putInTrie(result.title, result);
        }
    });

}

exports.Search = Search;
