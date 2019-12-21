find manifests -type f -exec sed -i 's/inherits ::selinux/inherits ::vox_selinux/g' {} \;
find manifests -type f -exec sed -i 's/include ::selinux/include ::vox_selinux/g' {} \;
find manifests -type f -exec sed -i 's/selinux::/vox_selinux::/g' {} \;
find manifests -type f -exec sed -i 's/Selinux::/Vox_selinux::/g' {} \;
find manifests -type f -exec sed -i 's/class selinux::/class vox_selinux::/g' {} \;
find manifests -type f -exec sed -i 's/^class selinux/class vox_selinux/g' {} \;
find manifests -type f -exec sed -i 's/include selinux/include vox_selinux/g' {} \;

find data -type f -exec sed -i "s/selinux::/vox_selinux::/" {} \;

find spec/classes -type f -exec sed -i "s/create_class(\('\|\"\)selinux/create_class(\1vox_selinux/g" {} \;
find spec/classes -type f -exec sed -i "s/contain_class(\('\|\"\)selinux/contain_class(\1vox_selinux/g" {} \;
find spec/classes -type f -exec sed -i "s/contain_selinux__/contain_vox_selinux__/g" {} \;
find spec/classes -type f -exec sed -i "s/describe \('\|\"\)selinux/describe \1vox_selinux/g" {} \;

find spec -type f -exec sed -i 's/selinux::/vox_selinux::/g' {} \;
find spec -type f -exec sed -i 's/Selinux::/Vox_selinux::/g' {} \;
find spec -type f -exec sed -i "s/contain_selinux__/contain_vox_selinux__/g" {} \;

# Silly, but don't have time to make this perfect right now
find spec -type f -exec sed -i 's/vox_vox/vox/g' {} \;
find manifests -type f -exec sed -i 's/Vox_vox/Vox/g' {} \;

read -r -d '' fork_msg <<'EOM'
---

> This module has been forked from
> (voxpupuli/selinux)[https://github.com/voxpupuli/puppet-selinux] so that it
> could be re-namespaced as `vox_selinux` for the
> (SIMP)[https://simp-project.com] framework.
>
> Migration to the upstream module will happen in the future after sufficient
> time has been provided for users to migrate away from the legacy SIMP
> provided module.
>
> Any changes made here should be sent in as PRs to the upstream module and
> this should not deviate from the upstream release outside of the namespace if
> at all possible.
>
> Per the Apache 2.0 license requirements, the following changes have been made:
> * Renamed the module from `puppet/selinux` to `simp/vox_selinux`
> * Changed the namespace for all components to `vox_selinux`
> * Updated the tests to reflect the changes
> * Disabled reporting to the `voxpupuli` channels on test failures
> * Updated .travis.yml for deployment and SIMP-style testing stages
> * Updated the README.md to note the changes
>
> You can see specifically how things were updated by reading the
> `simp_vox_migration.sh` script.

---
EOM

echo "Remember to add the following message (updated as appropriate) to README.md"
echo ''
echo "$fork_msg"
