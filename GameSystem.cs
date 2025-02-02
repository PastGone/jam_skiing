using Godot;

namespace ski;

public partial class GameSystem : Node
{
	
	public static Player Player => Game.Instance.Player;
	

	public static Vector2 ScreenPosition()
	{
		var camera2D = Player.Instance.GetNode<Camera2D>("Camera2D");
		return camera2D.GlobalPosition - new Vector2(5000, 0);
	}
}
