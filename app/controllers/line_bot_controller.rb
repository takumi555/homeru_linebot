class LineBotController < ApplicationController
  require 'line/bot'

  protect_from_forgery except: [:callback]

  def callback

    @post = Post.offset( rand(Post.count) ).first
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each { |event|

      if event.message['text'].include?("疲れた")
        response = "ひなのお疲れ様！今日もたくさん頑張ったもんね。ゆっくり休んでね！"
      elsif event.message['text'].include?("仕事行きたくない")
        response = "気持ちわかるよ。俺もだし、今から遊んじゃう？"
      elsif event.message['text'].include?("辞めたい")
        response = "なんとかなるよ"
      elsif event.message['text'].include?("ほんとに？")
        response = "うん"
      elsif event.message['text'].include?("かわいい")
        response = "ひなのは宇宙で一番かわいいよ！"
      elsif event.message['text'].include?("可愛い")
        response = "ひなのは人類史上最も可愛いよ！"
      elsif event.message['text'].include?("綺麗")
        response = "ウユニ塩湖よりもニュージーランドの満点の星空よりも、この世のなによりも綺麗だよ！"
      elsif event.message['text'] == "たくみ"
        response = "どうしたの？"
      elsif event.message['text'] == "たくみくん"
        response = "どうしたの？"
      elsif event.message['text'].include?("福原遥")
        response = "福原遥に似てるって言ってごめんね。あんまり嬉しくなかったみたいだけど、俺は可愛いと思ったから言ったよ。"
      elsif event.message['text'].include?("しよ")
        response = "いいね、しよ！"
      elsif event.message['text'].include?("いこ")
        response = "いいね、いこ！"
      elsif event.message['text'].include?("つらい")
        response = "拓実に連絡ちょうだい"
      elsif event.message['text'].include?("死ぬ")
        response = "本当に頑張ってるね。無理しないでね"
      elsif event.message['text'].include?("どこが好き")
        response = "全部。強いて言うなら仕事頑張ってるところと、優しいところ。あと顔と雰囲気がどタイプでした"
      elsif event.message['text'].include?("好き")
        response = "大好き"
      elsif event.message['text'].include?("寒い")
        response = "今日は雪だるまちゃん？"
      elsif event.message['text'].include?("なんでわかった")
        response = "あたりまえだろ"
      elsif event.message['text'].include?("暑い")
        response = "体調気をつけてね"
      elsif event.message['text'].include?("すご")
        response = "ひなのが一番すごい"
      else
        response = @post.name
      end

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: response
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }

    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

end