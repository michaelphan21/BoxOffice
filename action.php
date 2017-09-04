<?php
	
	require_once 'config.inc';
	
	$action = $_REQUEST['action'];
	
	if ($action == 'Add') {
		
       $movie_title = validate($_REQUEST['movie_title']);
	   $studio = validate($_REQUEST['studio']);
	   $year = validate($_REQUEST['year']);
	   $box_office = validate($_REQUEST['box_office']);
	   $Picture = validate($_REQUEST['Picture']);

	   $query = "SELECT * from movies WHERE movie_title='$movie_title' AND studio='$studio' AND year='$year' AND box_office='$box_office' AND Picture='$Picture'"; 
       $result = mysqli_query($conn, $query);
	   $duplicate = mysqli_num_rows($result);
	
		if($duplicate>0){
			header('refresh:0; url=index.php');
			echo '<script language="javascript">';
			echo 'alert("Duplicate entries are not allowed. Please try again.")';
			echo '</script>';
		}
		else if((!$studio) || (!$movie_title) || (!((int)$year)) || (!((int)$box_office))){
			header('refresh:0; url=index.php');		
			echo '<script language="javascript">';
			echo 'alert("Please enter valid inputs for ALL fields.")';
			echo '</script>';
		} 
		else {
		     $sql = "INSERT INTO movies (movie_title,studio,year,box_office, Picture) VALUES ('$movie_title' , '$studio' , '$year' , '$box_office', '$Picture')";
		     $result = mysqli_query($conn, $sql);
  		     header('Location: index.php');
		}
		
	} else if ($action == "Update") {
		
	   $movie_title = validate($_REQUEST['movie_title']);
	   $studio = validate($_REQUEST['studio']);
	   $year = validate($_REQUEST['year']);
	   $box_office = validate($_REQUEST['box_office']);	   
	   $movie_id = validate($_REQUEST['movie_id']);
	   $Picture = validate($_REQUEST['Picture']);
		
	   $query = "SELECT * from movies WHERE movie_title='$movie_title' AND studio='$studio' AND year='$year' AND box_office='$box_office' AND Picture='$Picture'"; 
       $result = mysqli_query($conn, $query);
	   $duplicate = mysqli_num_rows($result);
	
		if($duplicate>0){
			header('refresh:0; url=index.php');		
			echo '<script language="javascript">';
			echo 'alert("Duplicate entries are not allowed. Please try again.")';
			echo '</script>';
	
		}
		else if((!$studio) || (!$movie_title) || (!((int)$year)) || (!((int)$box_office))){
			header('refresh:0; url=index.php');		
			echo '<script language="javascript">';
			echo 'alert("Please enter valid inputs for ALL fields.")';
			echo '</script>';
	
		} 
		else {
			$sql = "UPDATE movies SET movie_title='" .$movie_title."' ,studio='".$studio."' ,year='".$year."' ,box_office='".$box_office."' ,Picture='".$Picture."' WHERE 	movie_id='".$movie_id."'";	     
			$result = mysqli_query($conn, $sql);
			header('Location: index.php');
		}	
	
		
	}  else if ($action == "Delete") {
  	     $sql = "DELETE FROM movies WHERE movie_id='".$_POST['movie_id']."'"; 
    	     $result = mysqli_query($conn, $sql);
	     header('Location: index.php');
	}

 	function validate($data) {
		$data = trim($data);
 		$data = stripslashes($data);
 		$data = htmlspecialchars($data);
 		return $data;
	  }
	
?>