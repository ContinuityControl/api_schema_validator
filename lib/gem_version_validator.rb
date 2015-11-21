class GemVersionValidator

  def self.fdic_latest?
    self.latest_fdic_version == self.installed_fdic_version
  end

  def self.ncua_latest?
    self.latest_ncua_version == self.installed_ncua_version
  end

  private

  def self.latest_fdic_version
    Gem.latest_version_for('fdic').to_s
  end

  def self.latest_ncua_version
    Gem.latest_version_for('ncua').to_s
  end

  def self.installed_fdic_version
    Gem.loaded_specs['fdic'].version.to_s
  end

  def self.installed_ncua_version
    Gem.loaded_specs['ncua'].version.to_s
  end
end
