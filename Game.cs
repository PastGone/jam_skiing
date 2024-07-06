using Godot;
using ski;

namespace Ski;

public partial class Game : Node2D
{
    public static Game Instance { get; private set; } = null!;
    public Cloud Cloud { get; private set; } = null!;
    public Build Build { get; private set; } = null!;
    public Pitfall Pitfall { get; private set; } = null!;
    public Player Player { get; private set; } = null!;

    public override void _Ready()
    {
        Instance = this;
        Cloud = GetNode<Cloud>("%Cloud");
        Build = GetNode<Build>("%Build");
        Pitfall = GetNode<Pitfall>("%Pitfall");
        Player = new(GetNode<CharacterBody2D>("%Player"));
    }
}