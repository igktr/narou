# -*- mode: ruby -*-
# -*- coding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "version"
require "fileutils"
module Narou
  def self.create_git_commit_version
    File.write("commitversion", `git describe --always`.strip)
    "commitversion"
  end
end
at_exit do
  if File.exist?("commitversion")
    FileUtils.rm("commitversion")
  end
end
Encoding.default_external = Encoding::UTF_8
Gem::Specification.new do |gem|
  gem.name          = "narou"
  gem.version       = Version
  gem.license       = "MIT"
  gem.authors       = ["whiteleaf7"]
  gem.email         = ["2nd.leaf@gmail.com"]
  gem.homepage      = "http://whiteleaf.hatenablog.com/"
  gem.summary       = %q{Narou.rb ― 小説家になろうダウンローダ＆縦書用整形スクリプト}
  gem.description   = %q{
小説家になろうで公開されている小説の管理、及び電子書籍データへの
変換を支援します。縦書用に特化されており、横書き用に特化されたWEB小説
を違和感なく縦書で読むことが出来るようになります。
}.split("\n").join
  install_message = <<-EOS
#{"*" * 60}

3.1.2 : 2017/06/10
------------------
#### 追加機能
- WEB UIにおいて、フィルターに入力されている状況をアドレスバーに反映するように
  しました。(ブックマークなどをすることでフィルターの状況を記憶・再現出来ます)

#### 修正内容
- WEB UIにおいて、凍結状態の表示状態に関わらず小説データを内部で取得していた事
  により、表示速度が低下していたのを修正しました
- 暁の常時 https 化に対応


3.1.1 : 2017/04/05
------------------
#### 追加機能
- `clean` コマンドを実装しました。サブタイトルの変更等により参照されなくなった
  ゴミファイルを削除することが出来ます。詳細は `narou clean -h`を参照して下さい
- WEB UI からメールを送信する機能を追加しました
  + Other ボタンと、個別メニューに追加されます

#### 修正内容
- Ruby 2.4 対応
- WEB UI のアバウトダイアログで、最新バージョンチェックが正しく動かなくなる場合
  があったのを修正
- WEB UI から「凍結済みでも更新」が使用出来ずにエラーが出ていたのを修正

#{"*" * 60}
  EOS
  gem.post_install_message = install_message.gsub("\t", "  ")

  gem.required_ruby_version = ">=2.1.0"

  gem.files = `git ls-files`.split("\n").reject { |fn| fn =~ %r!^spec/|^"spec! } << Narou.create_git_commit_version
  gem.executables = gem.files.grep(%r!^bin/!).map { |f| File.basename(f) }

  gem.add_runtime_dependency 'termcolorlight', '~> 1.0', '>= 1.1.1'
  gem.add_runtime_dependency 'rubyzip', '~> 1.1', '>= 1.1.0'
  gem.add_runtime_dependency 'mail', '2.5.4'
  gem.add_runtime_dependency 'pony', '~> 1.8'
  gem.add_runtime_dependency 'diff-lcs', '~> 1.2', '>= 1.2.5'
  gem.add_runtime_dependency 'sinatra', '~> 1.4', '>= 1.4.5'
  gem.add_runtime_dependency 'sinatra-contrib', '~> 1.4', '>= 1.4.2'
  gem.add_runtime_dependency 'tilt', '~> 2.0', '>= 2.0.1'
  gem.add_runtime_dependency 'sass', '~> 3.4', '>= 3.4.18'
  gem.add_runtime_dependency 'haml', '~> 4.0', '>= 4.0.7'
  gem.add_runtime_dependency 'memoist', '~> 0.11.0'
  gem.add_runtime_dependency 'systemu', '~> 2.6', '>= 2.6.5'
  gem.add_runtime_dependency 'erubis', '~> 2.7'
  gem.add_runtime_dependency 'open_uri_redirections', '~> 0.2', '>= 0.2.1'
end

