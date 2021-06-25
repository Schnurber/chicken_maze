<?php
require_once('conf.php');
/*
 * Aspekt fuer 
 *	Datenbank-Kommunikation
 */
trait DataBase{
	private static $connection=null;
	
	private static function connect(){
		$conf=conf();
		$conn=$conf['driver'].':host='.$conf['host'].';dbname='.$conf['database'];
		self::$connection = self::$connection ?: new \PDO($conn, $conf['user'], $conf['pass']);
	}
	
	public static function query(string $sql, array $vars = null){
		$arr=null;

		try {
			self::connect();
			$stmt = self::$connection->prepare($sql);
			if ($vars != null) {
				foreach ($vars as $key => $value) {
					if (is_array($value)) {
						$stmt->bindValue($key, $value[0], $value[1]);
					} else {
						$stmt->bindValue($key, $value);
					}
				}
			}
			$ok = $stmt->execute();
			$arr = $stmt->fetchAll();
		} catch (\PDOException $e) {
			error_log( 'Database Error: ' . $e->getMessage());
		}
		return $arr;
	}
	
}
?>
