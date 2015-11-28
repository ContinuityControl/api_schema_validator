require 'spec_helper'
require File.expand_path '../../lib/gem_version_validator.rb', __FILE__

describe GemVersionValidator do
  let(:local_version) { instance_double("Gem::Version") }
  let(:rubygems_version) { instance_double("Gem::Version") }
  let(:installed_fdic_version) { instance_double("Bundler::StubSpecification") }
  let(:installed_ncua_version) { instance_double("Bundler::StubSpecification") }
  let(:latest_fdic_version) { rubygems_version }
  let(:latest_ncua_version) { rubygems_version }

  context 'up to date gems' do
    let(:rubygems_version_string) { "0.5.0" }
    let(:local_version_string) { "0.5.0" }
    before :each do
      allow(rubygems_version).to receive(:to_s) { rubygems_version_string }
      allow(local_version).to receive(:to_s) { local_version_string }
      allow(installed_ncua_version).to receive(:version) { local_version }
      allow(installed_fdic_version).to receive(:version) { local_version }
      allow(Gem).to receive(:loaded_specs).and_return( { 'fdic' => installed_fdic_version,
                                                         'ncua' => installed_ncua_version })
    end

    describe '.fdic_latest?' do
      it 'should return true' do
        allow(Gem).to receive(:latest_version_for).with('fdic') { latest_fdic_version }
        expect(GemVersionValidator.fdic_latest?).to be_truthy
      end
    end

    describe '.ncua_latest?' do
      it 'should return true' do
        allow(Gem).to receive(:latest_version_for).with('ncua') { latest_ncua_version }
        expect(GemVersionValidator.ncua_latest?).to be_truthy
      end
    end
  end

  context 'out ofdate gems' do
    let(:rubygems_version_string) { "0.6.0" }
    let(:local_version_string) { "0.5.0" }
    before :each do
      allow(rubygems_version).to receive(:to_s) { rubygems_version_string }
      allow(local_version).to receive(:to_s) { local_version_string }
      allow(installed_ncua_version).to receive(:version) { local_version }
      allow(installed_fdic_version).to receive(:version) { local_version }
      allow(Gem).to receive(:loaded_specs).and_return( { 'fdic' => installed_fdic_version,
                                                         'ncua' => installed_ncua_version })
    end

    describe '.fdic_latest?' do
      it 'should return true' do
        allow(Gem).to receive(:latest_version_for).with('fdic') { latest_fdic_version }
        expect(GemVersionValidator.fdic_latest?).to be_falsey
      end
    end

    describe '.ncua_latest?' do
      it 'should return true' do
        allow(Gem).to receive(:latest_version_for).with('ncua') { latest_ncua_version }
        expect(GemVersionValidator.ncua_latest?).to be_falsey
      end
    end
  end
end
