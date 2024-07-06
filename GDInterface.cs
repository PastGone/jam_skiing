using Godot;

namespace ski;

public abstract class GDInterface<T> where T : Node
{
    public abstract T Instance { get; protected set; }
}