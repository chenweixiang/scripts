import os
import sys

def remove_last_extension_recursive(directory_path):
    """
    递归删除目录及其子目录下所有文件的最后一级扩展名
    """
    for root, dirs, files in os.walk(directory_path):
        for filename in files:
            file_path = os.path.join(root, filename)
            
            # 分割文件名和扩展名
            name_parts = filename.split('.')
            
            if len(name_parts) > 1:
                new_name = '.'.join(name_parts[:-1])
                new_path = os.path.join(root, new_name)
                
                if os.path.exists(new_path):
                    print(f"警告：跳过 '{filename}'，因为 '{new_name}' 已存在")
                    continue
                
                try:
                    os.rename(file_path, new_path)
                    print(f"重命名：'{os.path.relpath(file_path, directory_path)}' -> '{new_name}'")
                except Exception as e:
                    print(f"错误：无法重命名 '{filename}'，原因：{e}")

def main():
    # 获取用户输入的目录路径
    if len(sys.argv) > 1:
        directory = sys.argv[1]
    else:
        directory = input("请输入目录路径：")
    
    # 移除路径中的引号（如果用户输入时带引号）
    directory = directory.strip('"').strip("'").strip()
    
    # 执行重命名操作
    remove_last_extension_recursive(directory)
    
    print("\n操作完成！")

if __name__ == "__main__":
    main()
