@images = ["http://www.antelopepoint.us/wcam1.jpg","http://www.nps.gov/webcams-glca/bf1.jpg","http://www.nps.gov/webcams-glca/dr1.jpg","http://www.nps.gov/webcams-glca/hc1.jpg","https://www.nps.gov/webcams-glca/hi1.jpg","http://www.nps.gov/webcams-glca/po1.jpg","http://www.nps.gov/webcams-glca/ww2.jpg","http://www.nps.gov/webcams-glca/ww3.jpg"]

@directories = Dir.glob("webcams/*").sort_by(&:downcase)

begin
  @images.each_with_index do | img, i |
  puts "#{img} #{i} #{@directories[i]}"
  %x(curl -L #{img} -o #{@directories[i]}/#{Time.now.strftime('%m_%d_%y')}.jpg)
  end
rescue => e
  %x(echo #{e} >> logs.txt)
end
