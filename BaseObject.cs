using Godot;

namespace ski;

public partial class BaseObject : Node2D
{
    public override void _Ready()
    {
    }

    public override void _Process(double delta)
    {
        if (GlobalPosition.X <= GameSystem.ScreenPosition().X)
        {
            QueueFree();
            GD.Print("退出了");
        }
    }
}