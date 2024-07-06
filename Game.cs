using Godot;

namespace ski;

public partial class Game : Node2D
{
	public static Game Instance { get; private set; } = null!;
   
	public Player Player { get; private set; } = null!;
	

	public override void _Ready()
	{
		Instance = this;
		Player = new(GetNode<CharacterBody2D>("Player"));
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
