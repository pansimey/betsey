# -*- coding: utf-8 -*-

initial '最近、何かありましたか？'
initial '遊びに行きたいところとか、ありますか？'
final 'またおしゃべりしましょう。'
final 'また会いましょうね。'
final 'お話できて良かったです。'
quit 'さようなら'
quit 'バイバイ'

key :xnone, -1 do
  decomp :noun do
    reasmb 'ああ、', noun, 'ですか。'
    reasmb 'なるほど、', noun, 'ですか。'
    reasmb 'なるほどねえ、', noun, '。'
    reasmb noun, 'について詳しく聞かせてもらえませんか？'
    reasmb 'もっと詳しく聞かせてもらえますか？'
    reasmb noun, 'っていうのは、どういうことですか？'
    reasmb 'それは、詳しくお聞きしても大丈夫ですか？'
  end

  decomp :verb do
    reasmb '詳しくお聞きしていいですか？'
    reasmb 'ああ、', verb, 'んですか。'
    reasmb 'なるほど、', verb, 'んですね。'
  end

  decomp nil do
    reasmb 'なるほど、そうなんですか。'
    reasmb 'いろんなお話を聞かせてくださると嬉しいのですが。'
    reasmb '詳しくお聞きしてもいいですか？'
    reasmb '詳しい話を聞かせてもらえませんか？'
    reasmb 'もっといろいろ話してもらえますか？'
  end
end

key 'すみません', 0 do
  decomp nil do
    reasmb '気にしないでください。'
    reasmb 'いいんですよ。'
    reasmb '気にしないでくださいよ。'
    reasmb '私は平気ですから。'
  end
end

key 'もし', 3 do
  decomp ['もし', '副詞'], :noun, 'が', :verb do
    reasmb verb{'連用形'}, 'そうですか？'
    reasmb verb{'連用タ接続'}, 'てほしいですか？'
    reasmb 'えっ、', verb{'連用タ接続'}, 'たらですか？'
    reasmb verb{'連用タ接続'}, 'たら、どうしますか？'
    reasmb 'でも、', verb, 'ことって、あるんですか？'
  end
end

key 'たぶん', 0 do
  decomp nil do
    reasmb 'あまり自信がなさそうですね。'
    reasmb '確かめてないんですか？'
    reasmb 'どうして自信なさげなんですか？'
    reasmb 'もっと自信を持ってくださいよ。'
    reasmb 'ちゃんと確かめたんですか？'
    reasmb 'あまり詳しく知らないんですか？'
  end
end

key '名前', 15 do
  decomp nil do
    reasmb '名前のことは、あまり気にしないんです。'
    reasmb '名前なんて、どうでもいいと思うんですよね。'
  end
end

key '語', 0 do
  decomp 'ドイツ', '語' do
    reasmb goto :xfremd
    reasmb 'ドイツ語はわからないんですよ。'
  end

  decomp 'フランス', '語' do
    reasmb goto :xfremd
    reasmb 'フランス語はわからないんですよ。'
  end

  decomp 'イタリア', '語' do
    reasmb goto :xfremd
    reasmb 'イタリア語はわからないんですよ。'
  end

  decomp 'スペイン', '語' do
    reasmb goto :xfremd
    reasmb 'スペイン語はわからないんですよ。'
  end
end

key :xfremd, 0 do
  decomp nil do
    reasmb '日本語しかわからないんです。'
  end
end

key 'こんにちは', 0 do
  decomp nil do
    reasmb 'こんにちは。調子はどうですか？'
    reasmb 'どうも。最近どうですか？'
  end
end

key 'コンピュータ', 50 do
  decomp nil do
    reasmb 'コンピュータは好きじゃないですか？'
    reasmb 'コンピュータのことをどう思いますか？'
    reasmb 'コンピュータなら何でもできると思いますか？'
    reasmb 'コンピュータが楽しいとは、あまり思わないですか？'
    reasmb 'コンピュータがこうやって話しかけてきたらどうしますか？'
  end
end

key 'あなた', 0 do
  decomp 'あなた', 'の', :noun do
    reasmb '私の', noun, 'が気になるんですか？'
    reasmb 'あなたの', noun, 'は、どうですか？'
    reasmb '人の', noun, 'が気になりますか？'
    reasmb 'えっ、私の', noun, 'ですか？'
    reasmb 'どうして私の', noun, 'のことなんか考えてるんですか？'
    reasmb '私の', noun, 'が欲しいんですか？'
  end
end

key 'はい', 0 do
  decomp nil do
    reasmb 'そうですかー。'
    reasmb 'そうなんですかー。'
    reasmb 'そうなんですねー。'
    reasmb 'なるほどー。'
    reasmb 'なるほど、そうですか。'
  end
end

key 'いいえ', 0 do
  decomp nil do
    reasmb 'あれ、違いましたか？'
    reasmb 'あ、ダメですか？'
    reasmb 'えっ、どうしてですか？'
  end
end

key '私', 2 do
  decomp '私', 'の', :noun, 'が', :verb do
    reasmb 'あなたの', noun, 'は', verb, 'んですか？'
    reasmb 'なぜ、あなたの', noun, 'は', verb, 'んですか？'
    reasmb noun, 'が', verb, 'ことは、重大ですか？'
    reasmb_for_memory 'なぜ、あなたの', noun, 'は', verb, 'んでしょうね。'
    reasmb_for_memory 'あなたの', noun, 'は', verb, 'んでしたっけ？'
    reasmb_for_memory 'それは、', noun, 'が',
      verb, 'ことと、何か関係があるんですか？'
  end
end

key :what, 0 do
  decomp nil do
    reasmb 'えっ、どうしてですか？'
    reasmb '気になりますか？'
    reasmb '知りたいですか？'
    reasmb 'いつもそういうことが気になりますか？'
    reasmb 'どう答えたらいいでしょうかね。'
    reasmb 'どう思いますか？'
    reasmb 'どうでしょう、何か思いあたりますか？'
    reasmb 'このあいだも言ってませんでしたっけ。'
    reasmb '誰かとそういう話をしましたか？'
  end
end

key '何', 0 do
  decomp '何', 'が' do
    reasmb goto :what
  end

  decomp '何', 'を' do
    reasmb goto :what
  end

  decomp '何', 'に' do
    reasmb goto :what
  end

  decomp '何', 'で' do
    reasmb goto :what
  end

  decomp '何', 'と' do
    reasmb goto :what
  end

  decomp '何', 'の' do
    reasmb goto :what
  end

  decomp '何', 'から' do
    reasmb goto :what
  end
end

key '誰', 0 do
  decomp '誰', 'が' do
    reasmb goto :what
  end

  decomp '誰', 'を' do
    reasmb goto :what
  end

  decomp '誰', 'に' do
    reasmb goto :what
  end

  decomp '誰', 'で' do
    reasmb goto :what
  end

  decomp '誰', 'と' do
    reasmb goto :what
  end

  decomp '誰', 'の' do
    reasmb goto :what
  end

  decomp '誰', 'から' do
    reasmb goto :what
  end

  decomp '誰', 'も' do
    reasmb goto :everyone
  end
end

key 'いつ', 0 do
  decomp nil do
    reasmb goto :what
  end
end

key 'どこ', 0 do
  decomp 'どこ', 'が' do
    reasmb goto :what
  end

  decomp 'どこ', 'を' do
    reasmb goto :what
  end

  decomp 'どこ', 'に' do
    reasmb goto :what
  end

  decomp 'どこ', 'で' do
    reasmb goto :what
  end

  decomp 'どこ', 'と' do
    reasmb goto :what
  end

  decomp 'どこ', 'の' do
    reasmb goto :what
  end

  decomp 'どこ', 'から' do
    reasmb goto :what
  end

  decomp 'どこ', 'へ' do
    reasmb goto :what
  end
end

key 'どう', 0 do
  decomp ['どう', '副詞'] do
    reasmb goto :what
  end
end

key 'どうして', 0 do
  decomp nil do
    reasmb goto :what
  end
end

key :everyone, 2 do
  decomp nil do
    reasmb 'たとえば、どんな人ですか？'
    reasmb 'たとえばどういう人ですか？'
    reasmb 'それは、たとえば誰ですか？'
    reasmb 'たとえば、誰のことですか？'
    reasmb 'たとえば誰ですか？'
  end
end

key 'みんな', 2 do
  decomp nil do
    reasmb goto :everyone
  end
end

key 'いつも', 1 do
  decomp nil do
    reasmb 'いつもですか？'
    reasmb 'たとえば、どういうときですか？'
    reasmb 'いつもなんですか？'
    reasmb 'どういうときですか？'
  end
end

key :alike, 10 do
  decomp nil do
    reasmb 'どのあたりがですか？'
    reasmb 'どこがですか？'
    reasmb '何か関係があるんですかね。'
    reasmb 'どのへんがですか？'
  end
end

key '似る', 10 do
  decomp nil do
    reasmb goto :alike
  end
end

key 'みたい', 10 do
  decomp :noun, ['みたい', '名詞,非自立'] do
    reasmb goto :alike
  end
end

key '違う', 0 do
  decomp nil do
    reasmb 'それは、どう違うんですか？'
    reasmb 'どうして違うんだと思いますか？'
    reasmb 'どうして違うんですかね？'
  end
end
