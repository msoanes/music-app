module TracksHelper
  def ugly_lyrics(lyrics)
    lyrics ||= ''
    lines = lyrics.split(/\r\n/).map do |line|
      line.empty? ? '' : "♫#{line.strip}"
    end
    lines.join("\n")
  end
end
