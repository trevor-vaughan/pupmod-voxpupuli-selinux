find manifests -type f -exec sed -i 's/inherits ::selinux/inherits ::vox_selinux/g' {} \;
find manifests -type f -exec sed -i 's/include ::selinux/include ::vox_selinux/g' {} \;
find manifests -type f -exec sed -i 's/selinux::/vox_selinux::/g' {} \;
find manifests -type f -exec sed -i 's/Selinux::/Vox_selinux::/g' {} \;
find manifests -type f -exec sed -i 's/class selinux::/class vox_selinux::/g' {} \;

find data -type f -exec sed -i "s/selinux::/vox_selinux::/" {} \;

find spec/classes -type f -exec sed -i "s/create_class(\('\|\"\)selinux/create_class(\1vox_selinux/g" {} \;
find spec/classes -type f -exec sed -i "s/contain_class(\('\|\"\)selinux/contain_class(\1vox_selinux/g" {} \;
find spec/classes -type f -exec sed -i "s/contain_selinux__/contain_vox_selinux__/g" {} \;
find spec/classes -type f -exec sed -i "s/describe \('\|\"\)selinux/describe \1vox_selinux/g" {} \;
find spec/classes -type f -exec sed -i 's/selinux::/vox_selinux::/g' {} \;

find spec/defines -type f -exec sed -i 's/selinux::/vox_selinux::/g' {} \;
find spec/defines -type f -exec sed -i "s/contain_selinux__/contain_vox_selinux__/g" {} \;

# Silly, but don't have time to make this perfect right now
find spec -type f -exec sed -i 's/vox_vox/vox/g' {} \;
find manifests -type f -exec sed -i 's/Vox_vox/Vox/g' {} \;
