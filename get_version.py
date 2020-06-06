import pandas as pd

csv = pd.read_csv('https://omahaproxy.appspot.com/all')
csv = csv.filter(items = ['channel', 'v8_version'])
csv = csv.dropna()
csv = csv[csv['channel'] == 'stable']
versions = csv.v8_version.unique()

if len(versions) == 1:
	print(versions[0])
else:
	sys.exit('Version not found')