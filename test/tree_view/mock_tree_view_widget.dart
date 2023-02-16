import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class MockStatelessTreeView<T> extends StatelessWidget {
  final TreeNode<T> tree;

  const MockStatelessTreeView({super.key, required this.tree});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: TreeView.simple(
          tree: tree,
          expansionBehavior: ExpansionBehavior.scrollToLastChild,
          showRootNode: true,
          builder: (context, level, item) => ListTile(
            title: Text("Item ${item.level}-${item.key}"),
            subtitle: Text('Level $level'),
          ),
        ),
      ),
    );
  }
}

class MockStatefulTreeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MockStatefulTreeViewState();
}

class MockStatefulTreeViewState extends State<MockStatefulTreeView> {
  int stateCount = 0;

  void _nextTree() {
    setState(() {
      if (stateCount < testTrees.length - 1)
        stateCount++;
      else {
        stateCount = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: Stack(children: [
          TreeView.simple(
            tree: testTrees[stateCount].item1,
            expansionBehavior: ExpansionBehavior.scrollToLastChild,
            showRootNode: true,
            builder: (context, level, item) => ListTile(
              title: Text("Item ${item.level}-${item.key}"),
              subtitle: Text('Level $level'),
            ),
          ),
          TextButton(
            key: ValueKey("nextButton"),
            child: Text("Next"),
            onPressed: _nextTree,
          ),
        ]),
      ),
    );
  }
}

late final testTrees = <Tuple2<TreeNode, List<TreeNode>>>[
  Tuple2(defaultTree, []),
  Tuple2(nodesAddedTree, []),
  Tuple2(nodesRemovedTree, [
    TreeNode(key: "0C"),
    TreeNode(key: "0C1C"),
    TreeNode(key: "0C1C2A"),
    TreeNode(key: "0C1C2A3C"),
  ]),
];

TreeNode get defaultTree => TreeNode.root()
  ..addAll([
    TreeNode(key: "0A")
      ..addAll([
        TreeNode(key: "0A1A"),
      ]),
    TreeNode(key: "0B"),
    TreeNode(key: "0C")
      ..addAll([
        TreeNode(key: "0C1C")
          ..addAll([
            TreeNode(key: "0C1C2A")
              ..addAll([
                TreeNode(key: "0C1C2A3C"),
              ]),
          ]),
      ]),
  ]);

TreeNode get nodesAddedTree => TreeNode.root()
  ..addAll([
    TreeNode(key: "0A")
      ..addAll([
        TreeNode(key: "0A1A"),
      ]),
    TreeNode(key: "0B"),
    TreeNode(key: "0C")
      ..addAll([
        TreeNode(key: "0C1C")
          ..addAll([
            TreeNode(key: "0C1C2A")
              ..addAll([
                TreeNode(key: "0C1C2A3C"),
              ]),
          ]),
      ]),
    TreeNode(key: "0D"),
  ]);

TreeNode get nodesRemovedTree => TreeNode.root()
  ..addAll([
    TreeNode(key: "0A")
      ..addAll([
        TreeNode(key: "0A1A"),
      ]),
    TreeNode(key: "0B"),
    TreeNode(key: "0D"),
  ]);
