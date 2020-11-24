<?php
	require_once('Scores.php');

	$name = $_GET['name'];
	$score = $_GET['score'];
	$hash = $_GET['hash'];
	
	Scores::setScore($name, $score, $hash);


?>