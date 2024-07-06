using Godot;

namespace ski;

public class Player(CharacterBody2D characterBody2D) : GDInterface<CharacterBody2D>
{
    public override CharacterBody2D Instance
    {
        get => characterBody2D;
        protected set => characterBody2D = value;
    }
}