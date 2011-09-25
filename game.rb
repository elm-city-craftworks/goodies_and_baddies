require 'ray'

Ray.game "Test" do
  register { add_hook :quit, method(:exit!) }

  scene :square do
    @rect = Ray::Polygon.rectangle([-10, -10, 20, 20], Ray::Color.red)
    @rect.pos = [200,200]

    on :key_press, key(:left) do 
      @moving_left = true
    end

    on :key_release, key(:left) do
      @moving_left = false
    end

    render do |win|
      win.draw @rect
      @rect.pos += [-1,0] if @moving_left
    end
  end

  scenes << :square
end
