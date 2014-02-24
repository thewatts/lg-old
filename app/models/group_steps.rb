module GroupSteps

  def self.all
    [:basics, :specifics, :location, :submission, :approved]
  end

  def complete!(step)
    complete(step) unless invalid_step?(step)
  end

  def next_step
    (steps - completed_steps).first
  end

private

  def complete(step)
    completed_steps << step
    save
  end

  def invalid_step?(step)
    completed_steps.include?(step) || !steps.include?(step)
  end
end
