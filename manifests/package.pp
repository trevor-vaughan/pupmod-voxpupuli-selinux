# Manages additional packages required to support some of the functions.
#
# @api private
#
# @param manage_package See main class
# @param package_name See main class
#
class vox_selinux::package (
  $manage_package = $vox_selinux::manage_package,
  $package_name   = $vox_selinux::package_name,
){
  assert_private()
  if $manage_package {
    ensure_packages ($package_name)
  }
}
