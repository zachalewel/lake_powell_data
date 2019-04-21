require 'Time'

@images = ["http://www.antelopepoint.us/wcam1.jpg","http://www.nps.gov/webcams-glca/bf1.jpg","http://www.nps.gov/webcams-glca/dr1.jpg","http://www.nps.gov/webcams-glca/hc1.jpg","https://www.nps.gov/webcams-glca/hi1.jpg","http://www.nps.gov/webcams-glca/po1.jpg","http://www.nps.gov/webcams-glca/ww2.jpg","http://www.nps.gov/webcams-glca/ww3.jpg"]
@directories = Dir.glob("webcams/*").sort_by(&:downcase)
@counter = 0

def collect
  begin
    @images.each_with_index do | img, i |
      %x(curl -L #{img} -o #{@directories[i]}/#{Time.now.strftime('%m_%d_%y')}.jpg)
    end
    @counter += 1
  rescue => e
    %x(echo #{e} >> logs.txt)
  end
end

# Because we are using the cheapest hosting known to human kind.
# We are going to execute things based on timers and counters.
# Using sleep to limit the # of evaluations during the months
# this file will be running.

loop do
  time = Time.now.strftime("%H%M").to_i
  if time.between?(1200, 1201) && @counter < 1
    collect
  elsif time == 1202 && @counter > 0 
    @counter = 0
    sleep(86200)
  end
  sleep(15)
end 
