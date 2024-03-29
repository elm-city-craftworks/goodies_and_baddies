require 'ray'

Ray.game "Test" do
  register { add_hook :quit, method(:exit!) }

  scene :square do
    @rect = Ray::Polygon.rectangle([0, 0, 20, 20], Ray::Color.red)
    @rect.pos = [200,200]

    max_x = window.size.width - 20
    max_y = window.size.height - 20

    @goodies = 20.times.map do 
      x = rand(max_x) + 10
      y = rand(max_y) + 10
      
      g  = Ray::Polygon.rectangle([0,0,10,10])
      g.pos = [x,y]

      g
    end

    max_x = window.size.width  - 30
    max_y = window.size.height - 30

    @baddies = 5.times.map do
      x = rand(max_x) + 15
      y = rand(max_y) + 15
      g = Ray::Polygon.rectangle([0,0,15,15], Ray::Color.blue)
      g.pos += [x,y]
      g
    end
    
    always do
      if @rect.pos.x - 2 > 0
        @rect.pos += [-2, 0] if holding?(:left)
      end
 
      if @rect.pos.x + 2 < window.size.width
        @rect.pos += [2, 0] if holding?(:right)
      end

      if @rect.pos.y - 2 > 0
        @rect.pos += [0, -2] if holding?(:up)
      end

      if @rect.pos.y + 2 < window.size.height
        @rect.pos += [0, 2] if holding?(:down)
      end

      @goodies.reject! { |e| 
        [e.pos.x, e.pos.y, 10, 10].to_rect.inside?([@rect.pos.x, @rect.pos.y, 20, 20])
      }

      @baddies.each do |e|
        if e.pos.x < @rect.pos.x
          e.pos += [rand*2.5,0]
        else
          e.pos -= [rand*2.5,0]
        end

        if e.pos.y < @rect.pos.y
          e.pos += [0, rand*2.5]
        else
          e.pos -= [0, rand*2.5]
        end
      end

      @game_over ||= @baddies.any? { |e|
        [e.pos.x, e.pos.y, 15, 15].to_rect.collide?([@rect.pos.x, @rect.pos.y, 20,20])
      }
    end

    render do |win|
      if @goodies.empty?
        win.draw text("YOU WIN", :at => [100,100], :size => 60)
      elsif @game_over
        win.draw text("YOU LOSE", :at => [100,100], :size => 60)
      else
        @goodies.each { |g| win.draw(g) }
        @baddies.each { |g| win.draw(g) }
        win.draw @rect
      end
    end
  end

  scenes << :square
end
