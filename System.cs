using Godot;
using ski;

namespace Ski;

public partial class System : Node
{
    public static Cloud Cloud => Game.Instance.Cloud;
    public static Build Build => Game.Instance.Build;
    public static Pitfall Pitfall => Game.Instance.Pitfall;
    public static Player Player => Game.Instance.Player;
}