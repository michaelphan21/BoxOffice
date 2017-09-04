<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Box Office Tracker</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="/BoxOffice/css/style.css">
<link rel="stylesheet" type="text/css" href="/BoxOffice/js/jPages/css/jPages.css">

</head>
<body>

<div class="container">
	
<h1>Box Office Tracker</h1>
	
<table id="table" class="tablesorter table">
<thead>
	<tr>
		<th>Movie Title</th>
		<th>Studio</th>
		<th>Year</th>
		<th>Box Office</th>
		<th>Picture</th>
		<th></th>
	</tr>
</thead>

<!-- if there are no movies, display message. Otherwise, show movie list. -->
<tbody id="itemContainer">
	<?php
	   if (count($movies) == 0) {
	?>
	  <tr><td colspan='5'>No Movies</td></tr>

	<?php
	  } else {
		  		   
	     for ($i = 0; $i < count($movies); $i++) {
		    
		    print "<tr>";
		    print "<td>". $movies[$i]['movie_title'] . "</td>";
		    print "<td>". $movies[$i]['studio'] . "</td>";
		    print "<td>". $movies[$i]['year'] . "</td>";
		    print "<td>". $movies[$i]['box_office'] . "</td>";
			print '<td><img height="300" width="200" alt="images" src="/images/' . $movies[$i]['Picture'] . '" /></td>';
		    print "<td><div class='row'>";	    
		    print "<div class='col-sm-6'><button type='button' class='btn btn-default' onclick='SBC.editRecord(".json_encode($movies[$i]).")'>
	 		<span class='glyphicon glyphicon-pencil'></span></button></div>";
		    print "<div class='col-sm-6'><button type='button' class='btn btn-default' onclick='SBC.confirmDelete(".$movies[$i]['movie_id'].");'>
		    <span class='glyphicon glyphicon-trash'></span></button></div>";
	  	    print "</div></td></tr>\n"; 
		 }	
	  } 	  	  
	?>
</tbody>
</table>

<div class="holder"></div>

<!--- Pagination elements -->
<form>
	<label>Items per page:</label>
	<select>
		<option>5</option>
		<option>10</option>
		<option>20</option>
		<option value="100">All</option>
	</select>
</form>
<br>
<button type="button" id="addBtn" class="btn btn-primary btn-med"> Add </button>


<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Add Record</h4>
      </div>
     <div class="modal-body">

	 <form action="action.php" method="POST" class="form">
	 <div class="form-group">
	 	<label for="movie_title">Movie Title</label>
	 	<input type="text" name="movie_title" id="movie_title" value=""  class="form-control">
	 </div>

	 <div class="form-group">
	 	<label for="studio">Studio</label>
	 	<input type="text" name="studio" id="studio" value=""  class="form-control">
	 </div>

	<div class="form-group">
		<label for="year">Year</label>
		<input type="text" name="year" id="year" value=""  class="form-control">
	</div>

	<div class="form-group">
		<label>Box Office</label>
		<input type="text" name="box_office" id="box_office" value=""  class="form-control">
	</div>

	<div class="form-group">
		<label>Picture</label>
		<input type="file" name="Picture" id="Picture" class="form-control">
	</div>

	<input type="hidden" name="movie_id" id="movie_id" value="">
	
   
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="submit" class="btn btn-primary" name="action" id="actionBtn" value="Add">Add</button>
      </div>
   	</form>
   </div>
  </div>
 </div>
</div>


<!-- Delete modal -->
<div id="deleteModal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Confirm Delete</h4>
      </div>
      
      <div class="modal-footer">
      <form action="action.php" method="POST">
	  	<input type="hidden" name="movie_id" id="deleteConfirm_movie_id" value="">
	
	  	<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
        <button type="submit" class="btn btn-primary" name="action" value="Delete">Delete</button>
      </form>
      </div>
      
    </div>
  </div>
</div>

<!-- End partials -->

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="/BoxOffice/js/tablesorter/jquery.tablesorter.min.js"></script>
<script type="text/javascript" src="/BoxOffice/js/jPages/js/jPages.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script>
	$(document).ready(function () {
		
		$("#addBtn").click(function () {
		   SBC.editRecord();	
		})

		/* sort table */
		$("#table").tablesorter({widthFixed: true, widgets: ['zebra']});

		/* initiate pagination plugin */
		$("div.holder").jPages({
			containerID : "itemContainer",
			perPage     :  5

		});

		/* on select change, get new items per page */
		$("select").change(function(){
			var newPerPage = parseInt($(this).val());
			$("div.holder").jPages("destroy").jPages({
				containerID : "itemContainer",
				perPage     :  newPerPage
			});
		});
	});

	var SBC = {};
	
	SBC.confirmDelete = function confirmDelete(id) {
	  $("#deleteConfirm_movie_id").attr('value',id);
	  $('#deleteModal').modal('show');
	}
	
	
	SBC.editRecord = function editRecord(record) {
	  
	  if (!record) {
		// no data so it is a straight add
		
		$("#myModalLabel").html("Add Record");
	    $("#actionBtn").attr('value','Add');
	    $("#actionBtn").html('Add');
	    
	  } else {
	    // data passed so it is an edit
	    
	    $("#myModalLabel").html("Edit Record");
	  
	    $("#movie_title").attr('value',record.movie_title);
	    $("#studio").attr('value',record.studio);
	    $("#year").attr('value',record.year);
	    $("#box_office").attr('value',record.box_office);
	    $("#Picture").attr('value', record.Picture);
	    $("#movie_id").attr('value',record.movie_id);
	  
	    $("#actionBtn").attr('value','Update');
	    $("#actionBtn").html('Update');
	  }
	  
	 $('#addModal').modal('show');
	  
	}
</script>
</body>
</html>