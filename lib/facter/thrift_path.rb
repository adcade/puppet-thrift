Facter.add(:thrift_path) do
  confine :kernel => :linux
  setcode do
    path = Facter::Util::Resolution.exec("which thrift")
    if path
      path.to_s
    else
      nil
    end
  end
end
