<?php
	
	// CONNECT TO DB
    require_once 'config.inc';
       
    // FORM AND EXECUTE SOME QUERY
    $sql = "SELECT movie_id, movie_title,studio,year, box_office, Picture FROM movies ORDER BY movie_title";
    $result = mysqli_query($conn, $sql);
    
    $movies = $result->fetch_all(MYSQLI_ASSOC);
   
	// RENDER THE VIEW
    include('./views/app.tpl');
?>
