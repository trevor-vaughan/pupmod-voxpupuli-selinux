# Manages additional packages required to support some of the functions.
#
# @param manage_package See main class
# @param package_name See main class
#
# @api private
#
class vox_selinux::refpolicy_package (
  $manage_package = $vox_selinux::manage_package,
  $package_name   = $vox_selinux::refpolicy_package_name,
) inherits ::vox_selinux {
  assert_private()
  if $manage_package {
    ensure_packages ($package_name)
  }
}
