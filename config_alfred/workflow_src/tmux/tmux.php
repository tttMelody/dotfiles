<?php 

require_once('workflows.php');
/**
 * 
 **/
class Tmux
{
	
	public static function factory()
	{
		return new Tmux();
	}

	function __construct()
	{
		putenv("PATH=" .$_ENV["PATH"]. ':/opt/local/bin');
		$this->wb = new Workflows();
	}

	public function listSessions()
	{
		$shell_command = "tmux list-sessions | awk '{print $1}'";
		$results = array();
		$data = exec($shell_command, $results);
		
		for ($i = 0; $i < count($results); $i++) {
			$this->wb->result('tmux', 'tmux-session', $results[$i], 'session', 'icon.png');
		}
		
		return $this->wb->toxml();
	}

}
?>
