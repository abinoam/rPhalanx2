class Level1 < GameState

  attr_reader :player

  def initialize(window)
    super window
    @hud = Hud.new(self)
    @bg = Background.new(self)
    @player = Player.new(self)
    @objects.push(@hud)
    @objects.push(@bg)
    @objects.push(@player)
  end

  def button_down(id)
    super
    if id == Gosu::KbB
      @player.boost_change
    end
  end

  def left
    @player.left
  end

  def right
    @player.right
  end

  def up
    @player.up
  end

  def down
    @player.down
  end

  def space
    @player.fire
  end

  def rest
    @player.rest
  end

  def debug_spawn(max)
    roll = Random.new
    left_bound = self.window.width + 10
    right_bound = self.window.width + 20
    up_bound = 10
    bottom_bound = self.window.height - 20
    enemies = 0

    self.objects.each do |object|
      if object.tags.include? "enemy_ship"
        enemies += 1
      end
    end

    if enemies < max
      self.objects.push(Enemy.new(self,roll.rand(left_bound..right_bound),roll.rand(up_bound..bottom_bound)))
    end
  end

  def place_enemy
    # These dummies are just for testing.
    self.objects.push(Enemy.new(self,220,140))
    self.objects.push(Enemy.new(self,280,180))
    self.objects.push(Enemy.new(self,320,220))
    self.objects.push(Enemy.new(self,380,260))
    self.objects.push(Enemy.new(self,420,300))
  end

  # Used to stress-test.
  def place_swarm
    x = 150
    y = 10
    spacing = 20
    250.times do
      self.objects.push(Enemy.new(self,x,y))
      y += spacing
      if y > self.window.height - 30
        y = 10
        x += 40
      end
    end
  end

  def update
    super
    self.debug_spawn(10)
  end

  def draw
    super
  end
end
