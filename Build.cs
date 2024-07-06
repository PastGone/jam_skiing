using System;
using System.Collections.Generic;
using System.Linq;
using Godot;

namespace ski;

public partial class Build : Node2D
{
    [Export] private double _treeProbability = 2;
    public static BaseObject Tree1 => ResourceLoader.Load<PackedScene>("res://build/tree_1.tscn").Instantiate<BaseObject>();
    public static BaseObject Tree2 => ResourceLoader.Load<PackedScene>("res://build/tree_2.tscn").Instantiate<BaseObject>();
    public static BaseObject House => ResourceLoader.Load<PackedScene>("res://build/house.tscn").Instantiate<BaseObject>();


    public override void _Process(double delta)
    {
        if (CheckProbability(delta * _treeProbability))
        {
            Vector2 randomPoint = GetRandomPointOnLine(GameSystem.Line2D.Points);
            BaseObject tree = CheckProbability(0.5) ? Tree1 : Tree2;
            tree.Position = randomPoint;
            AddChild(tree);
        }

        if (CheckProbability(delta * 0.1))
        {
            Vector2 randomPoint = GetRandomPointOnLine(GameSystem.Line2D.Points);
            BaseObject tree = House;
            tree.Position = randomPoint;
            AddChild(tree);
        }
    }

    private static Vector2 GetRandomPointOnLine(Vector2[] points)
    {
        if (points == null || points.Length < 2)
            throw new ArgumentException("点集不能为空，并且必须包含至少两个点。");

        // 计算每段线段的长度，并累计到一个总长度中
        List<float> segmentLengths = [];
        var totalLength = 0f;

        for (var i = 0; i < points.Length - 1; i++)
        {
            var segmentLength = points[i].DistanceTo(points[i + 1]);
            segmentLengths.Add(segmentLength);
            totalLength += segmentLength;
        }

        // 生成一个0到总长度之间的随机数
        var randomLength = (float)GD.RandRange(0, totalLength);

        // 找到随机长度对应的线段和相对位置
        var accumulatedLength = 0f;
        for (var i = 0; i < segmentLengths.Count; i++)
        {
            if (accumulatedLength + segmentLengths[i] >= randomLength)
            {
                var segmentStartLength = accumulatedLength;
                var segmentLength = segmentLengths[i];
                var segmentPosition = (randomLength - segmentStartLength) / segmentLength;

                // 计算在线段上的那个点
                Vector2 startPoint = points[i];
                Vector2 endPoint = points[i + 1];
                Vector2 randomPoint = startPoint.Lerp(endPoint, segmentPosition);

                return randomPoint;
            }

            accumulatedLength += segmentLengths[i];
        }

        // 如果由于某种原因未能找到点，返回最后一个点
        return points[^1];
    }

    private static bool CheckProbability(double probability)
    {
        var randomValue = GD.RandRange(0.0, 1.0);
        return randomValue <= probability;
    }
}