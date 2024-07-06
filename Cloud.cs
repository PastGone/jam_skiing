using Godot;

namespace ski;

public partial class Cloud : Parallax2D
{
	public static BaseObject Cloud1 => ResourceLoader.Load<PackedScene>("res://build/cloud1.tscn").Instantiate<BaseObject>();

	public override void _Ready()
	{
	}

	public override void _Process(double delta)
	{
		
	}

	public override void _Draw()
	{
		
	}
}