<?php
	require_once('Scores.php');

	$scores = Scores::getScores();
	foreach ($scores as $value) {
				echo "$value[0], $value[1] <br>";
	}


?>