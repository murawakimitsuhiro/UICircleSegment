# UICircleSegment

Description
githubに作成物をあげたことがなかったのでお試しで自作のUIパーツをあげてみました。

UIKitのSegmentViewみたいなUIを丸くして２つの情報を表示できるようにしてみましたが、仕様用途はあまりないです…

## Demo
![サンプル画像](https://raw.githubusercontent.com/wiki/murawakimitsuhiro/UICircleSegment/images/sample.png)

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

## License
MIT license
