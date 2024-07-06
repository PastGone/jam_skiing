using Godot;

namespace ski;

public partial class Game : Node2D
{
    public static Game Instance { get; private set; } = null!;
    public Cloud Cloud { get; private set; } = null!;
    public Build Build { get; private set; } = null!;
    public Pitfall Pitfall { get; private set; } = null!;
    public Player Player { get; private set; } = null!;
    public Line2D Line2D { get; private set; } = null!;

    public override void _Ready()
    {
        Instance = this;
        Cloud = GetNode<Cloud>("%Cloud");
        Build = GetNode<Build>("%Build");
        Pitfall = GetNode<Pitfall>("%Pitfall");
        Player = new(GetNode<CharacterBody2D>("%Player"));
        Line2D = GetNode<Line2D>("地形/地段/Line2D");
    }

    public override void _Draw()
    {
        var rect2 = new Rect2
        {
            Position = GameSystem.ScreenPosition(),
            Size = new(2000,2000)
        };
        DrawRect(rect2,Colors.Blue);
    }
}