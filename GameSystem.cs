using Godot;

namespace ski;

public partial class GameSystem : Node
{
    public static Cloud Cloud => Game.Instance.Cloud;
    public static Build Build => Game.Instance.Build;
    public static Pitfall Pitfall => Game.Instance.Pitfall;
    public static Player Player => Game.Instance.Player;
    public static Line2D Line2D => Game.Instance.Line2D;

    public static Vector2 ScreenPosition()
    {
        var camera2D = Player.Instance.GetNode<Camera2D>("Camera2D");
        return camera2D.GlobalPosition - new Vector2(5000, 0);
    }
}