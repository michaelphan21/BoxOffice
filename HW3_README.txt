Michael Phan, A10024365
Harrison Wang, A10564594
CSE 135
08/28/2016

Our site: team135.tk/BoxOffice/index.php
Github Link: https://github.com/haw046/cse135/tree/master/BoxOffice

IMPORTANT: For image uploading, please use only the images that reside in the images directory.

Brief Overview
	Our Box Office Tracking app allows user to store information about movies into a database. It essentially allows the user to store (add button at the bottom of the page)  the movie title, studio, year of the movie, how much it made in the box office and also a picture or a poster of the movie. The user is given an option to add movies into the list. After the item has been added, the user is allow to edit and delete any items off that list as well (delete and edit button on the right side of the page). It also allows the user to go through a list of movies by traversing through several pages with the given option of viewing 5,10,20 or all items on the same page. The user also has another option to sort the headers in either an ascending or descending order.
	With emphasis on client-side programming, we allowed this page to be more interactive and responsive with the aid of jquery and Bootstrap. It provides a more smoother and friendlier view for the user. There isn’t any hard transitions into a next page since everything is done on ‘one’ page. 
For this assignment, the professor provided the students with 4 CRUD application with different implementation styles. According to what Professor Powell uploaded on Slack, we decided to use CRUD3 template to build off of. Harrison and I preferably wanted to approach the assignment with an emphasis on client side programming and minimal server side programming, and that was what CRUD3 provided. The CRUD app is set to be functional on only a single page rather than multiple ones.. Although it is compacted with an enormous amount of code, we thought the idea of having it run on a single page was more to our advantage and preferences. 
	For quality and organizational purposes, we broke up some code and stored them into their respective directories. Ex: We created a css directory the stores the style.css file, a js directory to store our jquery and javascript files, and a views directory to store our partial scripts. The main file (index.php) sits at the root directory of it all.

config.inc
	Our config file is essentially a global file that gets included into all other files since they need access to the database. We modified the template to include our own credentials along with setting up our own database as well.



index.php
	Index.php is the main file that the user interacts heavily with. It fetches all the data that is currently in the database and presents it to the user. For simplicity and organization purposes, we included the interactive aspects of the webpage in another page called app.tpl. We render this page by including the app.tpl view. 

action.php
	Our action.php file stores all of the actions that happen on the index page. These action consist of adding an item onto the database, deleting an item off the database, and modifying an item on the database. In addition, we added the validation form in this file. The purpose of validation here is to make our app more secured. It disallows users to hack and inject code into our database. We created a function called validate, which removes white spaces, backslashes, and turns special characters into HTML entities. Validate is called on the update and add action as those are where the user can input code to potentially hack the server.

app.tpl
This is where the main infrastructure of the webpage and implementation for client side programming happened, The other files were mainly revolved around server-side programming. We modified the template and made whatever changes necessary to match the writeup of the assignment (headers such as movie title, studio, etc..). Moreover, we added a sorting and a pagination feature to provide the user with a more comfortable and organized look. It allows data to be organized according to the user’s preferences by clicking the arrows next to the headers, which allows for an ascending or descending view. The user is also given the option to allow a certain amount of data from the table to be present. It gives the user sense of control and avoids the issue of crowding a lot of data together on one page. Both sorting and pagination were implemented by using the jquery plugins tablesorter and jPages, respectively. Lastly, the user is also able to add an image to the movie that they had listed (this was done by storing the filename into the DB and printing the file path to this image source).







