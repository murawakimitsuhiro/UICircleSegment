# UICircleSegment

Description

## Demo

## Requirements
Swiftでの作成になります。
storyboardではなくコーディングでUI設計する人向けです。

## Installation
ファイル内の```UISegmentViewController```のファイルをプロジェクトにコピーしてください。

ファイルにはUISegmentViewのクラスと個別のボタンのクラスが含まれています。

## Usage
以下サンプルです。CircleNumはサークルの数で、segmentViewのValue,およびsValueと同じ数を設定してください。

オプションは少ないので元クラスをカスタムして使っていただけると幸いです。
```
let segmentView = UICircleSegmentView(frame: CGRectMake(50, 200, self.view.frame.width-100, 200),
                                              CircleNum: 3,
                                              CircleSize: 100, sCircleSize: 40);
segmentView.value = ["ツイート", "フォロー", "フォロワー"];
segmentView.sValue = ["120", "92", "91"];
segmentView.addTarget(self, action: #selector(self.didChanged));
```
