<?php
require_once('DataBase.php');
require_once('conf.php');
 final class Scores  {
	use DataBase;

	static function setScore($name, $score, $hashv) {
		$str = $name.$score.conf()['secret'];
		$testhash = hash('sha256', $str);
		echo $str."<br>";
		echo $testhash."<br>";
		echo $hashv."<br>";
		if ($testhash != $hashv) return;
		// insert
		$user = preg_replace('/[^A-Za-z ]+/', '', $name);
		$tstr = "select * from cm_highscores where username=:name and score=:score limit 1";
		$anz = count(self::query($tstr, array(':name'=>$user, ':score'=>$score)));
		echo "Duplicate: $anz";
		if ($anz > 0) return;
		// $qstr = "insert ignore into cm_highscores set username = :name, score = :score";
		$qstr = "insert into cm_highscores values (NULL,:name,:score)";	
		self::query($qstr, array(':name'=>$user, ':score'=>$score));
		$anz = self::query("select count(*) from cm_highscores")[0][0];
		$todelete = $anz - 100;

		//Delete more than one or one?

		if ($todelete > 0) {
			self::query("delete from cm_highscores order by score asc limit :todel", array(':todel'=>array($todelete, PDO::PARAM_INT)));
			//error_log(("Deleted:".$todelete));
			
		}
	}

	static function getScores() {
		$scores = self::query("select username, score from cm_highscores order by score DESC");
		return $scores;
	}
}
?>
